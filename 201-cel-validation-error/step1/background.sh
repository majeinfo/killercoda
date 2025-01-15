cat <<EOF | kubectl apply -f -
apiVersion: admissionregistration.k8s.io/v1alpha1
kind: ValidatingAdmissionPolicy
metadata:
  name: image-tag-latest
spec:
  failurePolicy: Fail # if an expression evaluates to false, the validation check is enforced according to this field
  matchConstraints:
    resourceRules:
      - apiGroups:   [""]
        apiVersions: ["v1"]
        operations:  ["CREATE", "UPDATE"]
        resources:   ["pods"]
  validations:
    # the field below contains a CEL expression to validate the request
    - expression: |
        object.spec.containers.all(container,
          container.image.contains(":") &&
          [container.image.substring(container.image.lastIndexOf(":")+1)].all(image,
            !image.contains("/") && !(image in ["latest", ""])
          )
        )
      message: "Image tag 'latest' is not allowed. Use a tag from a specific version."
EOF

cat <<EOF | kubectl apply -f -
apiVersion: admissionregistration.k8s.io/v1alpha1
kind: ValidatingAdmissionPolicyBinding
metadata:
  name: image-tag-latest
spec:
  policyName: image-tag-latest # references a `ValidatingAdmissionPolicy` name
  validationActions: [Deny] # `Deny` specifies that a validation failure results in a denied request
  matchResources: {} # an empty `matchResources` means that all resources matched by the policy are validated by this binding
EOF

touch /tmp/finished

