require 'pg'
require 'cgi'
cgi = CGI.new

connection = PG::connect(dbname: "cdp")
connection.internal_encoding = "UTF-8"

data = cgi.params['input']
connection.exec("insert into sample values(#{data.first}, '#{data.last}');")

# データを受け取った後、HTMLの形式でレスポンス（反応）を返す
cgi.out("type" => "text/html", "charset" => "UTF-8") {
  "<html>
    <body>
      <p>以下の評価を受信しました</p>
      <p>ポイント：#{data.first}</p>
      <p>コメント：#{data.last}</p>
    </body>
  </html>"
}