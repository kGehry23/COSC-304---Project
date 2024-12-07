<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
    productList = new HashMap<String, ArrayList<Object>>();
}

// Add new product selected
// Get product information
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
Integer quantity = new Integer(1);

// Check available stock from the database
int availableStock = 0;
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String sql = "SELECT quantity FROM productInventory WHERE productId = ?";
    try (PreparedStatement pstmt = con.prepareStatement(sql)) {
        pstmt.setString(1, id);
        try (ResultSet rst = pstmt.executeQuery()) {
            if (rst.next()) {
                availableStock = rst.getInt("quantity");
            }
        }
    }
} catch (SQLException e) {
    e.printStackTrace();
}

// Store product information in an ArrayList
ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);
product.add(quantity);


// Update quantity if add same item to order again
if (productList.containsKey(id))
{	product = (ArrayList<Object>) productList.get(id);
    int curAmount = ((Integer) product.get(3)).intValue();
    if (curAmount < availableStock) {
        product.set(3, new Integer(curAmount + 1)); // Increment quantity only if stock is available
    }
} else {
    product.add(availableStock); // Add available stock to the product details
    productList.put(id, product);
}

// Update session with the modified cart
session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />
