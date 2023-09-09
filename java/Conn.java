public class Conn {
	public String db;
	public String user;
	public String passwd;
	public String port;
	public String host;
	public String strdriver;
	public String driver;

	public String connString;

	public Conn() {}
	public String connstr() {
		String cstr = this.strdriver + this.host + ":" + this.port + "/" + this.db;
		return cstr;
	}
}
