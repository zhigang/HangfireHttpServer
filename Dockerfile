# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
ARG TARGETOS TARGETARCH
RUN dotnet restore --runtime $TARGETOS-$TARGETARCH
RUN dotnet publish -c Release -o /app/publish --runtime $TARGETOS-$TARGETARCH --self-contained false

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
ENV ASPNETCORE_URLS=http://*:5000
EXPOSE 5000
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "HangfireHttpServer.dll"]