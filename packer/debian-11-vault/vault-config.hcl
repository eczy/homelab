storage "raft" {
  path    = "/opt/vault/data"
  node_id = "raft_node_0"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_cert_file = "/etc/vault.d/tls.crt"
  tls_key_file = "/etc/vault.d/tls.key"
}

api_addr = "https://vault.home.lan:8200"
cluster_addr = "https://vault.home.lan:8201"
ui = true