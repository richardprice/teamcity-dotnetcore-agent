FROM jetbrains/teamcity-agent:latest

ENV NUGET_XMLDOC_MODE=skip \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    GIT_SSH_VARIANT=ssh

RUN rm -rf /usr/share/dotnet
RUN rm -rf /usr/bin/dotnet
RUN rm -rf dotnet.tar.gz
RUN curl -SL https://download.microsoft.com/download/8/8/5/88544F33-836A-49A5-8B67-451C24709A8F/dotnet-sdk-2.1.300-linux-x64.tar.gz --output dotnet.tar.gz \
        && mkdir -p /usr/share/dotnet \
        && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
        && rm dotnet.tar.gz \
        && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet && \
    \
    mkdir warmup \
        && cd warmup \
        && dotnet new \
        && cd .. \
        && rm -rf warmup \
        && rm -rf /tmp/NuGetScratch && \
    \
    apt-get clean all && \
    \
    usermod -aG docker buildagent
