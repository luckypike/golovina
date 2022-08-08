use diesel::pg::PgConnection;
use diesel::r2d2::ConnectionManager;
use diesel::r2d2::Pool;
use diesel::r2d2::PooledConnection;

pub fn create_pool(url: &String) -> ConnectionPool {
    let manager = ConnectionManager::<PgConnection>::new(url);

    Pool::builder()
        .max_size(10)
        .build(manager)
        .unwrap()
}


pub type ConnectionPool = Pool<ConnectionManager<PgConnection>>;
pub type Connection = PooledConnection<ConnectionManager<PgConnection>>;
