FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

COPY . ./
WORKDIR /app/SampleWebApiAspNetCore
RUN dotnet restore

RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/SampleWebApiAspNetCore/out .
ENV ASPNETCORE_ENVIRONMENT=Development

EXPOSE 80

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]