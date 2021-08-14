<%

MembershipUser membershipUser = Membership.GetUser();
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null)
    out.println(" <h3> Signed in as: "+userName+"</h3>");
    yourdiv.InnerHtml = userName;
%>