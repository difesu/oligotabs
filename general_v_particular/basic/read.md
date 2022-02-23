docker build -t basic-postgresql ./
docker images -a
TESTCONTAINERID=$(docker run -d --name basic-postgresql-container -p 5432:5432 basic-postgresql)
docker start $TESTCONTAINERID
