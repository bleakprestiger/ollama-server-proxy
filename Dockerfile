FROM python:3.11
USER root
# Update packagtes, install necessary tools into the base image, clean up and clone git repository
RUN apt update \
    && apt install -y --no-install-recommends --no-install-suggests git apache2 \
    && apt autoremove -y --purge \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && git clone https://github.com/bleakprestiger/ollama-server-proxy.git
    #&& git clone https://github.com/ParisNeo/ollama_proxy_server.git
# Change working directory to cloned git repository
WORKDIR  ollama-server-proxy
#RUN chmod 777 ollama_proxy_server
# Install all needed requirements
RUN pip3 install -e .

# Copy config.ini and authorized_users.txt into project working directory
COPY config.ini .
COPY authorized_users.txt .
COPY entrypoint.sh .
#RUN chmod +x /entrypoint.sh

# Start the proxy server as entrypoint
#ENTRYPOINT ["ollama_proxy_server"]
ENTRYPOINT ["./entrypoint.sh"]
CMD ["ollama_proxy_server","-h"]
EXPOSE 7860
#CMD ["./entrypoint.sh"]
# Set command line parameters
#CMD ["--config", "./config.ini", "--users_list", "./authorized_users.txt", "--port", "7860"]
#CMD ["--config ./config.ini --users_list ./authorized_users.txt --port 7860;wait"]