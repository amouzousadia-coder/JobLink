public interface CloudProvider {
    void storeFile(String name);
    String getFile(String name);
    void createServer(String region);
    void listServers(String region);
    String getCDNAddress();
}

public class Amazon implements CloudProvider {

    @Override
    public void storeFile(String name) {
        System.out.println("Amazon: storing file " + name);
    }

    @Override
    public String getFile(String name) {
        System.out.println("Amazon: fetching file " + name);
        return name;
    }

    @Override
    public void createServer(String region) {
        System.out.println("Amazon: creating server in region " + region);
    }

    @Override
    public void listServers(String region) {
        System.out.println("Amazon: listing servers in region " + region);
    }

    @Override
    public String getCDNAddress() {
        System.out.println("Amazon: returning CDN address");
        return "cdn.amazon.com/resource";
    }
}

public class Dropbox implements CloudProvider {

    @Override
    public void storeFile(String name) {
        System.out.println("Dropbox: storing file " + name);
    }

    @Override
    public String getFile(String name) {
        System.out.println("Dropbox: fetching file " + name);
        return name;
    }

    @Override
    public void createServer(String region) {
        throw new UnsupportedOperationException("Dropbox does not support server creation.");
    }

    @Override
    public void listServers(String region) {
        throw new UnsupportedOperationException("Dropbox does not support server listing.");
    }

    @Override
    public String getCDNAddress() {
        throw new UnsupportedOperationException("Dropbox does not provide CDN services.");
    }
}
