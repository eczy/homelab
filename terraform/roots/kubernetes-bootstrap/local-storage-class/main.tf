module "kustomize_apply" {
  source = "../../../modules/kubernetes/kustomize_apply"

  kustomize_path = "${path.module}/kustomize/base"
}