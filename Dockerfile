# Use the official .NET SDK image as a build environment
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Copy the project file and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET runtime image as the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the default port for ASP.NET applications
EXPOSE 80

# Define the entry point for the container
ENTRYPOINT ["dotnet", "dotnet-semver.dll"]
