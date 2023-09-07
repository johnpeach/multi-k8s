docker build -t johnppeach/multi-client:latest -t johnppeach/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnppeach/multi-server:latest -t johnppeach/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnppeach/multi-worker:latest -t johnppeach/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johnppeach/multi-client:lastest
docker push johnppeach/multi-client:$SHA
docker push johnppeach/multi-server:latest
docker push johnppeach/multi-server:$SHA
docker push johnppeach/multi-worker:latest
docker push johnppeach/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=johnppeach/multi-server:$SHA
kubectl set image deployments/client-delpoyment client=johnppeach/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johnppeach/multi-worker:$SHA
