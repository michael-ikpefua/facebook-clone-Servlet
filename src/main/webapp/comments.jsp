<%@ page import="com.michael.facebook.model.User" %>
<%@ page import="java.awt.*" %>
<%@ page import="com.michael.facebook.model.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.michael.facebook.data_access_object.PostDAO" %>
<%@ page import="com.michael.facebook.data_access_object.UserDAO" %>
<%@ page import="com.michael.facebook.model.Comment" %>
<%@ page import="com.michael.facebook.data_access_object.CommentDAO" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/nav.jsp"%>

<div class="container">

    <div class="row">
        <div class="col-lg-3">
            <div class="shadow p-3 mb-5 bg-body rounded text-center">
                <img class="profile-pic-icon-three mt-4" src="assets/images/avatar.png" alt="">
                <h5 class="mt-3">Post Author: <%
                    User postAuthor = (User) request.getAttribute("user");
                    Post post = (Post) request.getAttribute("post");
                    out.print(postAuthor.getName());

                %>
                </h5>

            </div>
        </div>
        <div class="col-lg-9">


            <div class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <h4 class="text-center">View Posts</h4>
                    <h6 class="card-subtitle mb-2 text-muted">
                        <%= post.getBody() %>
                    </h6>
                    <p class="text-muted"><%=post.getCreatedAt()%></p>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button class="btn btn btn-outline-primary">Like</button>
                            <button class="btn btn btn-outline-warning">Dislike</button>
                        </div>
                        <a href="#" class="btn btn-danger float-end">Delete Post</a>
                    </div>
                </div>
            </div>

            <div class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <div class="col-lg-1">
                        <img class="profile-pic-icon-two" src="/assets/images/avatar.png" alt="">
                    </div>
                    <form action="<%=request.getContextPath()%>/post" method="post">
                        <input type="hidden" name="page" value="update_post">
                        <input type="hidden" name="post_id" value="<%= post.getId() %>">
                        <input type="hidden" name="post_author_id" value="<%= post.getUser_id() %>">
                        <div class="col-lg-11 text-right">
                            <textarea class="form-control drag" name="body" placeholder="write a post"><%= post.getBody() %></textarea>
                            <button class="btn btn-success btn-md mt-3 btn-block" type="submit">Update Post</button>
                        </div>
                    </form>
                </div>
            </div>


            <div class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <form action="<%=request.getContextPath()%>/comment" method="post">
                        <input type="hidden" name="post_id" value="<%= post.getId() %>">
                        <div class="row">
                            <div class="col-lg-10">
                                <input type="text" name="body" class="form-control comment-form">
                            </div>
                            <div class="col-lg-2">
                                <button type="submit" class="btn btn-primary btn-sm btn-block">Add Comment</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%
                ArrayList<Comment> comments = (ArrayList<Comment>) request.getAttribute("comments");
                if(comments.size() == 0){
            %>
                <h4 style="text-align: center; color: #ffffff;">No Comment Added for this Post!!</h4>
            <%
            } else {
                    out.println("<h4> Comments </h4>");
                    for(Comment comment : comments)
                    {
        %>
            <div id="section-one" class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <div class="col-lg-1">
                        <img class="profile-pic-icon-two" src="/assets/images/avatar.png" />
                    </div>
                    <div class="col-lg-11">
                        <h5 class="postName">
                            <%
                                User commentAuthor = (new UserDAO().getUserById(comment.getUser_id()));
                                out.print(commentAuthor.getName());
                            %>
                        </h5>
                        <b>

                        </b>
                        <h6 class="card-subtitle mb-2 text-muted">
                            <%= comment.getBody() %>
                        </h6>
                        <p class="post-date">Likes and Dis Likes Here</p>


                    </div>

                </div>
            </div>
            <%
                }
                }
            %>

        </div>

    </div>
</div>
<div class="container">
    <div class="row">
        <nav aria-label="...">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item" aria-current="page">
                    <a class="page-link" href="#">2</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<footer class="text-center mt-5 mb-5">Java Book - 2021</footer>
<script type="text/javascript">
    function removesection_one(){
        document.getElementById('section-one').remove();
    }
    function removesection_two(){
        document.getElementById('section-two').remove();
    }
    function removesection_three(){
        document.getElementById('section-three').remove();
    }
</script>


<%@include file="/includes/footer.jsp" %>
