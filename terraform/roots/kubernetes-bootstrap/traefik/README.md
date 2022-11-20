# traefik

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kustomize_apply"></a> [kustomize\_apply](#module\_kustomize\_apply) | ../../../modules/kubernetes/kustomize_apply | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.traefik](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.traefik_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
