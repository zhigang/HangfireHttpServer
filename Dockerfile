# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore -a $TARGETARCH
RUN dotnet publish -c Release -o /app/publish -a $TARGETARCH

FROM --platform=$TARGETPLATFORM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
ENV ASPNETCORE_URLS=http://*:5000
EXPOSE 5000
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "HangfireHttpServer.dll"]