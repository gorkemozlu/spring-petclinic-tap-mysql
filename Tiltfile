SOURCE_IMAGE = os.getenv("SOURCE_IMAGE", default='harbor.dorn.gorke.ml/tap/app-name-dev-bundle')
LOCAL_PATH = os.getenv("LOCAL_PATH", default='.')
NAMESPACE = os.getenv("NAMESPACE", default='nspace')
allow_k8s_contexts('gorkemo-tap')
k8s_custom_deploy(
    'app-name',
    apply_cmd="tanzu apps workload apply -f config/deploy/tap/workload.yaml --live-update" +
               " --local-path " + LOCAL_PATH +
               " --source-image " + SOURCE_IMAGE +
               " --namespace " + NAMESPACE +
               " --yes >/dev/null" +
               " && kubectl get workload app-name --namespace " + NAMESPACE + " -o yaml",
    delete_cmd="tanzu apps workload delete -f config/deploy/tap/workload.yaml --namespace " + NAMESPACE + " --yes",
    deps=['pom.xml', './target/classes'],
    container_selector='workload',
    live_update=[
      sync('./target/classes', '/workspace/BOOT-INF/classes')
    ]
)

k8s_resource('app-name', port_forwards=["8080:8080"],
            extra_pod_selectors=[{'serving.knative.dev/service': 'app-name'}])
