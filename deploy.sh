docker build -t anmol2srivastava/multi-client:latest -t anmol2srivastava/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t anmol2srivastava/multi-server:latest -t anmol2srivastava/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anmol2srivastava/multi-worker:latest -t anmol2srivastava/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anmol2srivastava/multi-client:latest
docker push anmol2srivastava/multi-server:latest
docker push anmol2srivastava/multi-worker:latest
docker push anmol2srivastava/multi-client:$SHA
docker push anmol2srivastava/multi-server:$SHA
docker push anmol2srivastava/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=anmol2srivastava/multi-client:$SHA
kubectl set image deployments/server-deployment server=anmol2srivastava/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=anmol2srivastava/multi-worker:$SHA