# Set variables
RG_NAME="azure-play-terraform-state-rg"
STORAGE_ACCOUNT="tfstate$RANDOM"   # must be globally unique
CONTAINER_NAME="tfstate"

# Create resource group
az group create --name $RG_NAME --location eastus

# Create storage account
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RG_NAME \
  --sku Standard_LRS \
  --encryption-services blob

# Get access key
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RG_NAME \
  --account-name $STORAGE_ACCOUNT \
  --query '[0].value' -o tsv)

# Create container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT \
  --account-key $ACCOUNT_KEY