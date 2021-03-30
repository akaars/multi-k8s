docker build -t akaars/multi-client:latest -t akaars/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t akaars/multi-server:latest -t akaars/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akaars/multi-worker:latest -t akaars/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akaars/multi-client:latest
docker push akaars/multi-client:$SHA

docker push akaars/multi-server:latest
docker push akaars/multi-server:$SHA

docker push akaars/multi-worker:latest
docker push akaars/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA