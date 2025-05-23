using NLog;
using NLog.Web;
using HangfireHttpServer;

var logger = NLog.LogManager.Setup()
    .LoadConfigurationFromAppSettings()
    .GetCurrentClassLogger();

try
{
    logger.Debug("init main");

    var builder = WebApplication.CreateBuilder(args);

    // Configure logging
    builder.Logging.ClearProviders();

    builder.Host.UseNLog();

    // Add services to the container
    builder.Services.AddSelfHangfire(builder.Configuration);

    var app = builder.Build();

    app.ConfigureSelfHangfire(builder.Configuration);

    await app.RunAsync();
}
catch (Exception ex)
{
    logger.Error(ex, "Stopped program because of exception");
    throw;
}
finally
{
    LogManager.Shutdown();
}

