# ╭──────────────────────────────────────────────────────────────────────╮
# │ Zscaler certificate config                                           │
# │ per https://help.zscaler.com/zia/adding-custom-certificate-...      │
# ╰──────────────────────────────────────────────────────────────────────╯
export REQUESTS_CA_BUNDLE="$HOME/.config/zscaler/combined-ca-bundle.pem"
export CURL_CA_BUNDLE="$HOME/.config/zscaler/combined-ca-bundle.pem"
export NODE_EXTRA_CA_CERTS="$HOME/.config/zscaler/combined-ca-bundle.pem"
