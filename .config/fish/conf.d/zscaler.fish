# Zscaler certificate config per https://help.zscaler.com/zia/adding-custom-certificate-application-specific-trust-store
# Python
# set --global --export REQUESTS_CA_BUNDLE $HOME/.config/zscaler/zscaler-root-ca.pem
set --global --export REQUESTS_CA_BUNDLE $HOME/.config/zscaler/combined-ca-bundle.pem
set --global --export CURL_CA_BUNDLE $HOME/.config/zscaler/combined-ca-bundle.pem

# NPM
# set --global --export NODE_EXTRA_CA_CERTS $HOME/.config/zscaler/zscaler-root-ca.pem
set --global --export NODE_EXTRA_CA_CERTS $HOME/.config/zscaler/combined-ca-bundle.pem

# Ruby, OpenSSL
# set --global --export SSL_CERT_FILE $HOME/.config/zscaler/combined-ca-bundle.pem.pem

# Google Cloud SDK
# gcloud config --quiet --verbosity=none set core/custom_ca_certs_file "$HOME/.config/zscaler/combined-ca-bundle.pem"
