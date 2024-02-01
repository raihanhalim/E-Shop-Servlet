<%@page import="com.mycompany.e.shop.entities.Category"%>
<%@page import="com.mycompany.e.shop.entities.Product"%>
<%@page import="com.mycompany.e.shop.dao.CategoryDao"%>
<%@page import="com.mycompany.e.shop.dao.ProductDao"%>
<%@page import="com.mycompany.e.shop.helper.FactoryProvider"%>
<%@page import="com.mycompany.e.shop.helper.Helper"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Shop - Home</title>
        <%@include file="components/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        
        <div class="container">
            <div class="row mt-3 mx-2">
                <%
                    String cat = request.getParameter("category");
                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;
                    
                    if (cat == null || cat.trim().equals("all")) {
                        list = dao.getAllProducts();
                    } else {
                        int cid = Integer.parseInt(cat.trim());
                        list = dao.getAllProductsById(cid);
                    }
                    
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All Products
                        </a>
                        <%
                            for (Category c : clist) {
                        %>
                        <a href="index.jsp?category=<%= c.getCategoryId()%>" class="list-group-item list-group-item-action">
                            <%= c.getCategoryTitle()%>
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="col-md-10 mt-4">
                    <div class="row row-cols-1 row-cols-md-4 g-4">
                        <%
                            for (Product p : list) {
                        %>
                        <div class="col">
                            <div class="card">
                                <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 200px; max-width: 100%; width: auto" class="card-img-top m-2" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title"><%= p.getpName()%></h5>
                                    <p class="card-text"><%= Helper.get10Words(p.getpDesc())%></p>
                                </div>
                                <div class="card-footer">
                                    <button class="btn custom-bg btn-sm" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%= p.getpPrice()%>)">Add To Cart</button>
                                    <button class="btn btn-outline-primary btn-sm">&dollar;<%= p.getpPrice()%></button>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                            
                            if (list.size() == 0) {
                                out.println("<h3>No Item In This Category</h3>");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="components/common_modals.jsp"%>
    </body>
</html>
