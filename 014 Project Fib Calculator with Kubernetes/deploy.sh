docker build -t cygnetops/multi-client-k8s:latest -t cygnetops/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t cygnetops/multi-server-k8s-pgfix:latest -t cygnetops/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t cygnetops/multi-worker-k8s:latest -t cygnetops/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push cygnetops/multi-client-k8s:latest
docker push cygnetops/multi-server-k8s-pgfix:latest
docker push cygnetops/multi-worker-k8s:latest

docker push cygnetops/multi-client-k8s:$SHA
docker push cygnetops/multi-server-k8s-pgfix:$SHA
docker push cygnetops/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cygnetops/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=cygnetops/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=cygnetops/multi-worker-k8s:$SHA