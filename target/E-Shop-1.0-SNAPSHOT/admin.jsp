<%@page import="com.mycompany.e.shop.entities.User"%>
<%@page import="com.mycompany.e.shop.entities.Category"%>
<%@page import="com.mycompany.e.shop.dao.CategoryDao"%>
<%@page import="com.mycompany.e.shop.helper.FactoryProvider"%>
<%@page import="java.util.List"%>
<%
    User user = (User) session.getAttribute("current-user");
    
    if (user == null) {
        session.setAttribute("message", "You Are Not Logged In !! Login First");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You Are Not Admin ! Do Not Access This Page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Shop - Admin Panel</title>
        <%@include file="components/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp"%>
        
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp"%>
            </div>
            <div class="row mt-3">
                <!-- first col -->
                <div class="col-md-4">
                    <!-- first box -->
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/team.png" alt="user_icon"/>
                            </div>
                            <h1>2342</h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <!-- second col -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/menu.png" alt="categories_icon"/>
                            </div>
                            <h1>23432</h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <!-- third col -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/offer.png" alt="product_icon"/>
                            </div>
                            <h1>234</h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>
            </div>
            <!-- second row -->
            <div class="row mt-3">
                <!-- second row : first col -->
                <div class="col-md-6">
                    <!-- first box -->
                    <div class="card" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/keys.png" alt="add_category_icon"/>
                            </div>
                            <p class="mt-2">Click Here To Add New Category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>
                <!-- second row : second col -->
                <div class="col-md-6">
                    <div class="card" data-bs-toggle="modal" data-bs-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded-circle" src="img/plus.png" alt="add_product_icon"/>
                            </div>
                            <p class="mt-2">Click Here To Add New Product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- add category modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header custom-bg">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Fill Category Details</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group mb-3">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required/>
                            </div>
                            <div class="form-group mb-3">
                                <textarea style="height: 150px" class="form-control" name="catDescription" placeholder="Enter Category Description" required></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- add product modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header custom-bg">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Product Details</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct">
                            <div class="form-group mb-3">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Title Of Product" required/>
                            </div>
                            <div class="form-group mb-3">
                                <textarea style="height: 150px" class="form-control" name="pDesc" placeholder="Enter Product Description" required></textarea>
                            </div>
                            <div class="form-group mb-3">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Price Of Product" required/>
                            </div>
                            <div class="form-group mb-3">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required/>
                            </div>
                            <div class="form-group mb-3">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required/>
                            </div>
                            <%
                                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> list = cdao.getCategories();
                            %>
                            <div class="form-group mb-3">
                                <select name="catId" class="form-control" id="">
                                    <%
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <label for="pPic">Select Picture Of Product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" required/>
                            </div>
                            
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
