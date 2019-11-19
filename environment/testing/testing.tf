provider "azurerm" {
    version = "~> 1.36"
}
resource "azurerm_resource_group" "netcdTestingRG" {
    name = "netcdTestingResourceGroup"
    location = "southeastasia"

    tags = {
        environment = "NetCD Testing"
    }
}

resource "azurerm_virtual_network" "netcdNetwork" {
    name                = "netcdVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "southeastasia"
    resource_group_name = "${azurerm_resource_group.netcdTestingRG.name}"

    tags = {
        environment = "NetCD Testing"
    }
}

resource "azurerm_subnet" "mainSubnet" {
    name                 = "mainSubnet"
    resource_group_name  = "${azurerm_resource_group.netcdTestingRG.name}"
    virtual_network_name = "${azurerm_virtual_network.netcdNetwork.name}"
    address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "netcdTestingIP1" {
    name                         = "netcdTestingIP1"
    location                     = "southeastasia"
    resource_group_name          = "${azurerm_resource_group.netcdTestingRG.name}"
    allocation_method            = "Dynamic"
    domain_name_label            = "netcdtestingip1"

    tags = {
        environment = "NetCD Testing"
    }
}

resource "azurerm_network_security_group" "netcdTestingSG" {
    name                = "netcdTestingSG"
    location            = "southeastasia"
    resource_group_name = "${azurerm_resource_group.netcdTestingRG.name}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "NetCD Testing"
    }
}

resource "azurerm_network_interface" "vm1nic" {
    name                        = "vm1nic"
    location                    = "southeastasia"
    resource_group_name         = "${azurerm_resource_group.netcdTestingRG.name}"
    network_security_group_id   = "${azurerm_network_security_group.netcdTestingSG.id}"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.mainSubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.netcdTestingIP1.id}"
    }

    tags = {
        environment = "NetCD Testing"
    }
}

resource "azurerm_virtual_machine" "k8sMaster1" {
    name                  = "k8sMaster1"
    location              = "southeastasia"
    resource_group_name   = "${azurerm_resource_group.netcdTestingRG.name}"
    network_interface_ids = [azurerm_network_interface.vm1nic.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-DAILY-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "k8s-master"
        admin_username = "netcd"
        admin_password = "netcd123456"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/netcd/.ssh/authorized_keys"
            key_data = "ssh-rsa ***REMOVED***cbBbH0ftJ9TM***REMOVED******REMOVED******REMOVED******REMOVED***pu8lkLA3Bife0CrG9yXVtde6ttCHCspE/t7SIw== ***REMOVED***"
        }
    }

    # boot_diagnostics {
    #     enabled     = "false"
    #     # storage_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    # }

    tags = {
        environment = "NetCD Testing"
    }
}