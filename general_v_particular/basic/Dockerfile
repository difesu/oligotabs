FROM postgres
ENV POSTGRES_PASSWORD alvPutaBatillo
ENV POSTGRES_DB gen_v_part_1

ADD init.sql /docker-entrypoint-initdb.d
ADD populate.sql /docker-entrypoint-initdb.d