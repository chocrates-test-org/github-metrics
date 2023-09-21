resource "kubernetes_manifest" "elasticsearch" {
  depends_on = [
    kubernetes_namespace.insights
  ]
  manifest = {
    apiVersion = "elasticsearch.k8s.elastic.co/v1"
    kind       = "Elasticsearch"
    metadata   = {
      name      = "elasticsearch"
      namespace = var.namespace
    }
    spec = {
      version  = "8.9.0"
      nodeSets = [
        {
          name   = "master"
          config = {
            "node.roles" = ["master"]
          }
          count                = 3
          volumeClaimTemplates = [
            {
              metadata = {
                name = "elasticsearch-data"
              }
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources   = {
                  requests = {
                    storage = "1024Gi"
                  }
                }
                storageClassName = "default"
              }
            }
          ]
          podTemplate = {
            metadata = {
              labels = {
                app = "elasticsearch"
              }
            }
            spec = {
              containers = [
                {
                  name      = "elasticsearch"
                  resources = {
                    requests = {
                      memory = "4Gi"
                      cpu    = 2
                    }
                    limits = {
                      memory = "8Gi"
                      cpu    = 4
                    }
                  }
                }
              ]
              initContainers = [
                {
                  name            = "sysctl"
                  securityContext = {
                    privileged = true
                    runAsUser  = 0
                  }
                  command = ["sh", "-c", "sysctl -w vm.max_map_count=262144"]
                }
              ]
            }
          }
        },
        {
          name   = "node"
          config = {
            "node.roles" = ["data"]
          }
          count                = 5
          volumeClaimTemplates = [
            {
              metadata = {
                name = "elasticsearch-data"
              }
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources   = {
                  requests = {
                    storage = "1024Gi"
                  }
                }
                storageClassName = "default"
              }
            }
          ]
          podTemplate = {
            metadata = {
              labels = {
                app = "elasticsearch"
              }
            }
            spec = {
              containers = [
                {
                  name      = "elasticsearch"
                  resources = {
                    requests = {
                      memory = "16Gi"
                      cpu    = 4
                    }
                    limits = {
                      memory = "32Gi"
                      cpu    = 8
                    }
                  }
                }
              ]
              initContainers = [
                {
                  name            = "sysctl"
                  securityContext = {
                    privileged = true
                    runAsUser  = 0
                  }
                  command = ["sh", "-c", "sysctl -w vm.max_map_count=262144"]
                }
              ]
            }
          }
        },
        {
          name   = "ingest"
          config = {
            "node.roles" = ["ingest"]
          }
          count                = 3
          volumeClaimTemplates = [
            {
              metadata = {
                name = "elasticsearch-data"
              }
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources   = {
                  requests = {
                    storage = "1024Gi"
                  }
                }
                storageClassName = "default"
              }
            }
          ]
          podTemplate = {
            metadata = {
              labels = {
                app = "elasticsearch"
              }
            }
            spec = {
              containers = [
                {
                  name      = "elasticsearch"
                  resources = {
                    requests = {
                      memory = "16Gi"
                      cpu    = 4
                    }
                    limits = {
                      memory = "32Gi"
                      cpu    = 8
                    }
                  }
                }
              ]
              initContainers = [
                {
                  name            = "sysctl"
                  securityContext = {
                    privileged = true
                    runAsUser  = 0
                  }
                  command = ["sh", "-c", "sysctl -w vm.max_map_count=262144"]
                }
              ]
            }
          }
        },
        {
          name   = "transform"
          config = {
            "node.roles" = ["transform"]
          }
          count                = 3
          volumeClaimTemplates = [
            {
              metadata = {
                name = "elasticsearch-data"
              }
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources   = {
                  requests = {
                    storage = "1024Gi"
                  }
                }
                storageClassName = "default"
              }
            }
          ]
          podTemplate = {
            metadata = {
              labels = {
                app = "elasticsearch"
              }
            }
            spec = {
              containers = [
                {
                  name      = "elasticsearch"
                  resources = {
                    requests = {
                      memory = "16Gi"
                      cpu    = 4
                    }
                    limits = {
                      memory = "32Gi"
                      cpu    = 8
                    }
                  }
                }
              ]
              initContainers = [
                {
                  name            = "sysctl"
                  securityContext = {
                    privileged = true
                    runAsUser  = 0
                  }
                  command = ["sh", "-c", "sysctl -w vm.max_map_count=262144"]
                }
              ]
            }
          }
        }
      ]
    }
  }
}
