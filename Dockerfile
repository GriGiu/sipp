FROM alpine:latest

# Aggiorna l'indice dei pacchetti
RUN apk update

# Installa le dipendenze per la compilazione di sipp
RUN apk add --no-cache build-base libpcap-dev autoconf automake git

# Crea una directory di lavoro all'interno del container
WORKDIR /app

# Clona il repository git di sipp
RUN git clone https://github.com/SIPp/sipp .

# Genera gli script di configurazione (se necessario)
RUN sh autogen.sh

# Compila sipp
RUN make -j$(nproc)

# Installa sipp
RUN make install

# Pulisci le dipendenze di build per ridurre la dimensione dell'immagine (opzionale per questo esempio)
# RUN apk del build-base libpcap-dev autoconf automake git

# Comando di default per eseguire sipp (opzionale, l'utente può sovrascriverlo)
# CMD ["sipp", "-h"]
