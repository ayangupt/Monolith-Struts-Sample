<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<div class="inner">
  <div class="logo"><html:link page="/home.do">Ski Resort Shop</html:link></div>
  <ul class="app-nav">
    <li><html:link page="/home.do">ホーム</html:link></li>
    <li><html:link page="/products.do">商品</html:link></li>
    <li><html:link page="/coupons/available.do">クーポン</html:link></li>
    <logic:present name="loginUser" scope="session">
      <li><html:link page="/orders.do">注文履歴</html:link></li>
      <li><html:link page="/points.do">ポイント</html:link></li>
      <li><html:link page="/addresses.do">住所帳</html:link></li>
      <logic:equal name="loginUser" property="role" value="ADMIN">
        <li><html:link page="/admin/products.do">管理:商品</html:link></li>
        <li><html:link page="/admin/orders.do">管理:注文</html:link></li>
        <li><html:link page="/admin/coupons.do">管理:クーポン</html:link></li>
        <li><html:link page="/admin/shipping.do">管理:配送方法</html:link></li>
      </logic:equal>
    </logic:present>
    <logic:notPresent name="loginUser" scope="session">
      <li><html:link page="/login.do">ログイン</html:link></li>
      <li><html:link page="/register.do">会員登録</html:link></li>
    </logic:notPresent>
  </ul>
  <div class="actions">
    <html:form action="/products.do" method="get" styleClass="header-search">
      <input type="text" name="keyword" value="" placeholder="商品名やブランドで検索" />
      <button type="submit">🔍</button>
    </html:form>
    <html:link page="/cart.do" styleClass="btn">🛒 カート</html:link>
    <logic:present name="loginUser" scope="session">
      <span class="user-name">こんにちは、<bean:write name="loginUser" property="username"/></span>
      <html:link page="/logout.do">ログアウト</html:link>
    </logic:present>
    <logic:notPresent name="loginUser" scope="session">
      <html:link page="/login.do">ログイン</html:link>
      <html:link page="/register.do" styleClass="btn">会員登録</html:link>
    </logic:notPresent>
  </div>
</div>
