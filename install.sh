echo "Welcome to the t3rn Executor Setup by CryptoBdarija"

sudo apt -q update
npm install -g pm2

cd $HOME
mkdir T3RN; cd T3RN;
LOGFILE="/root/T3RN//executor.log"






echo "Downloading executor-linux-v0.29.0.tar.gz..."
curl -L -O https://github.com/t3rn/executor-release/releases/download/v0.29.0/executor-linux-v0.29.0.tar.gz


echo "Extracting the file..."
tar -xvzf executor-linux-v0.29.0.tar.gz


# Check if extraction was successful
if [ $? -eq 0 ]; then
    echo "Extraction successful."
else
    echo "Extraction failed, please check the tar.gz file."
    exit 1
fi

# Check if the extracted files contain 'executor'
echo "Checking if the extracted files or directories contain 'executor'..."
if ls | grep -q 'executor'; then
    echo "Check passed, found files or directories containing 'executor'."
else
    echo "No files or directories containing 'executor' were found, possibly incorrect file name."
    exit 1
fi






export NODE_ENV=testnet
export LOG_LEVEL=debug
export LOG_PRETTY=false
export EXECUTOR_PROCESS_ORDERS=true
export EXECUTOR_PROCESS_CLAIMS=true
export EXECUTOR_MAX_L3_GAS_PRICE=200
export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,optimism-sepolia,l1rn'




read -s -p "Enter your Private Key from Metamask [Burner Wallet]: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

# Start the executor process with pm2
pm2 start ./executor/executor/bin/executor --name executor --log "$LOGFILE" --env NODE_ENV=$NODE_ENV --env LOG_LEVEL=$LOG_LEVEL --env LOG_PRETTY=$LOG_PRETTY --env ENABLED_NETWORKS=$ENABLED_NETWORKS --env PRIVATE_KEY_LOCAL="$PRIVATE_KEY_LOCAL";

echo "Setup complete! The Executor is now running."
echo "Subscribe: https://t.me/Crypto_Bdarija1"

pm2 logs executor;



