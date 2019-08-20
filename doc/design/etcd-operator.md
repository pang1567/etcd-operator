## 简单走读etcd-operator的doc文件，了解设计思路和功能重点：
etcd-operator作为官方提供的一个operator示例，简化了etcd这种有状态服务集群的部署和配置，为开发者提供更直观的理解k8s的operator机制。开发者也可以考虑通过operator对其它有状态服务做定制和开发。
从而更好的利用k8s。
 ```http   
    Deployment
    https://kubernetes.io/zh/docs/tasks/run-application/run-stateless-application-deployment/

    StatefulSet
    https://kubernetes.io/zh/docs/tutorials/stateful-application/basic-stateful-set/
    https://www.kubernetes.org.cn/statefulset

    http://docs.devops.oa.com/%E6%89%80%E6%9C%89%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/kubernetes%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88/statefulset%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3.html
    http://docs.devops.oa.com/%E6%89%80%E6%9C%89%E6%9C%8D%E5%8A%A1/%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1/kubernetes%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88/%E5%90%83%E8%B1%86%E5%B0%8F%E6%B8%B8%E6%88%8F%E6%A1%88%E4%BE%8B.html?h=statefulset

    Tidb-operator
    http://tapd.oa.com/tsf4webgame/markdown_wikis/#1010031051009616129
```
## etcd-operator创建和销毁，etcd集群创建和销毁
```yaml
    - kubectl delete -f example/deployment.yaml // 删除operator

    - kubectl apply -f example/deployment.yaml  // 创建operator

    - kubectl delete -f example/example-etcd-cluster.yaml // 删除etcd集群

    - kubectl apply -f example/example-etcd-cluster.yaml  // 创建etcd集群

    - kubectl describe etcdcluster/example-etcd-cluster  // 查看当前集群的状态

    - backup和restore operator因为环境限制不做演示，只了解功能，有必要可以简单走读下代码
```
## 随机停止etcd节点，写入数据后，读取，验证
- 使用脚本持续随机停止一个etcd节点 delete_pod.sh 
- 设置etcdclient的环境变量 set_env.sh  
- 持续写入，put.sh
- 写入结束后，读取，读取过程中停止节点随机停止的操作。get.sh
- 验证是否有丢数据现象

## 简单走读etcd-operator的代码，了解etcd-operator的doc文件，了解设计思路和功能

- 创建服务
- 创建pod
- 发现扩缩容，自动根据策略扩缩容 
- 发现需要升级，则根据业务特性滚动升级
- 备份直接参考文档
- 恢复参考文档

reconciliation.md 参考

## 区别operator，deployment，stateful的区别
An Operator is an application-specific controller that extends the Kubernetes API to create, configure and manage instances of complex stateful applications on behalf of 
a Kubernetes user. It builds upon the basic Kubernetes resource and controller concepts, but also includes domain or application-specific knowledge to automate common tasks
better managed by computers.


> 结论：deployment是k8s上无状态服务的资源类型，StatefulSet是k8s上有状态服务资源。operator通过扩展k8s的api的特定应用控制器，用来帮助用户配置和管理复杂的有状态服务。它是在基于k8s的资源和控制器上包含了特定应用程序的业务相关去自动化完成一些任务。

## 如何配合G6
G6只是将服务部署到了k8s上，做镜像，配置yaml，下发配置等操作。相对来说比较简单，也不复杂。
Tbuspp如果只是部署到k8s上，相对来说也比较简单，可以先提供镜像给G6，还是让alex他们自己做镜像？
   
## 方案目前现状
   - Mac上2018开头的doc文档以及桌面的架构图
   - 


## 附录
```yaml
nslookup web-0.nginx.default.svc.cluster.local

 kubectl patch statefulset web --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"bk.artifactory.oa.com:8443/paas/tk/nginx:1.17.3"}]'
 kubectl patch statefulset web --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"bk.artifactory.oa.com:8443/paas/tk/nginx:latest"}]'

 
 ```