Note: Vault requires some manual initialization after apply. See [here] for details

[here]: https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-raft<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >=0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.vault](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.vault_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
