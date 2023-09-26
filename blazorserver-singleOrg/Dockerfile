FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 44318

ENV ASPNETCORE_URLS=http://+:44318

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["blazorserver-singleOrg/blazorserver-singleOrg.csproj", "blazorserver-singleOrg/"]
RUN dotnet restore "blazorserver-singleOrg/blazorserver-singleOrg.csproj"
COPY . .
WORKDIR "/src/blazorserver-singleOrg"
RUN dotnet build "blazorserver-singleOrg.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "blazorserver-singleOrg.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "blazorserver-singleOrg.dll"]
