use actix_web::{web, App, HttpResponse, HttpServer, Responder};

async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello from Nix!")
}

#[tokio::main]
async fn main() -> std::io::Result<()> {
    println!("🌐 Starting server at http://localhost:8080");

    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(hello))
    })
        .bind("127.0.0.1:8080")?
        .run()
    .await
}
