FROM alpine:latest

# Aggiorna l'indice dei pacchetti
RUN apk update

# Installa le dipendenze necessarie per compilare Sipp
# build-base:  Fornisce strumenti essenziali per la compilazione (gcc, make, etc.)
# libpcap-dev: Libreria per la cattura di pacchetti, necessaria per Sipp
# autoconf e automake: Strumenti per la generazione automatica degli script di build
# git:             Necessario per clonare il repository di Sipp da GitHub
RUN apk add --no-cache build-base libpcap-dev autoconf automake git

# Crea una directory di lavoro all'interno del container
WORKDIR /app

# Clona il repository Git di Sipp dal repository ufficiale su GitHub
# In questo modo otteniamo il codice sorgente più recente
RUN git clone https://github.com/SIPp/sipp.git .

# Rendi eseguibile lo script autogen.sh
RUN chmod +x autogen.sh

# Esegui autogen.sh per generare gli script di configurazione e Makefile
# Questo passaggio è necessario per preparare l'ambiente di build a partire dal codice sorgente
RUN sh autogen.sh

# Compila Sipp utilizzando il comando 'make'.
# L'opzione '-j$(nproc)' permette di usare tutti i core della CPU per velocizzare la compilazione.
RUN make -j$(nproc)

# Installa Sipp nel sistema del container
# Questo comando copia l'eseguibile 'sipp' in una directory standard (come /usr/local/bin)
RUN make install

# Pulisci le dipendenze di build per ridurre la dimensione finale dell'immagine Docker
# Questo è opzionale, ma consigliato per immagini Docker più leggere.
# Rimuoviamo gli strumenti di compilazione e git che non sono più necessari dopo l'installazione di Sipp.
RUN apk del build-base autoconf automake git

# Definisci il comando di default da eseguire quando si avvia il container
# In questo caso, mostriamo l'help di Sipp per verificare che l'installazione sia corretta
CMD ["sipp", "-h"]
