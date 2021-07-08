# Makefile for navigation corrections software

FC = gfortran
CC = gcc
FFLAGS = -g
CFLAGS = -g
LDFLAGS = 

# Libraries
NETCDF = /usr/local
LIBS = -L${NETCDF}/lib -lnetcdf -lnetcdff -lcurl -lhdf5 -lhdf5_hl
INCLUDES = -I${NETCDF}/include
CLIBS = -lgeotiff -ltiff

all: readnetcdf_DBZ_VR cns_eldo_cai aster2txt

*.o:
	${FC} ${FFLAGS} ${LDFLAGS} -c $? ${INCLUDES}

cns_eldo_cai: cns_eldo_cai.f chol_inv.f
	${FC} ${FFLAGS} ${LDFLAGS} -o $@ $? ${LIBS} ${INCLUDES}

readnetcdf_DBZ_VR: readnetcdf_DBZ_VR.f90
	${FC} ${FFLAGS} ${LDFLAGS} -o $@ $? ${LIBS} ${INCLUDES}

aster2txt: aster2txt.o
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ $? ${CLIBS} ${CINCLUDES}

clean:
	rm -f core *.o *~ 

