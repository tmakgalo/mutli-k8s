docker build -t dudamakgalo/multi-client-k8s:latest -t dudamakgalo/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t dudamakgalo/multi-server-k8s-pgfix:latest -t dudamakgalo/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t dudamakgalo/multi-worker-k8s:latest -t dudamakgalo/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push dudamakgalo/multi-client-k8s:latest
docker push dudamakgalo/multi-server-k8s-pgfix:latest
docker push dudamakgalo/multi-worker-k8s:latest

docker push dudamakgalo/multi-client-k8s:$SHA
docker push dudamakgalo/multi-server-k8s-pgfix:$SHA
docker push dudamakgalo/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dudamakgalo/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=dudamakgalo/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=dudamakgalo/multi-worker-k8s:$SHA