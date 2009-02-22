require 'hpricot'
class Mp < BasicModel
  database_name :demand

  validates_presence_of :name

  def self.get_mp_from_site(postal_code)
    postal_code = postal_code.gsub(/[^A-Za-z0-9]/, '').upcase

    resp = ""
    http = Net::HTTP.new("www2.parl.gc.ca")
    http.start do |http|
      req = Net::HTTP::Get.new("/Parlinfo/Compilations/HouseOfCommons/MemberByPostalCode.aspx?Menu=HOC&PostalCode=" + postal_code,
        {"User-Agent" => "spider"})
      response = http.request(req)
      resp = response.body
    end

    doc = Hpricot(resp)

    name = doc.search("#ctl00_cphContent_repMP_ctl00_lnkPerson").inner_html.strip
    (last_name, first_name) = name.split(", ")
    name = "#{first_name} #{last_name}".strip

    #ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_Label5
    paddress = "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_Label5").inner_html}\n" +
      "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_Label7").inner_html}\n" +
      "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_Label8").inner_html}\n"

    laddress = "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label3").inner_html}\n" +
      "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label12").inner_html}, " +
      "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label4").inner_html}\n" +
      "#{doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label13").inner_html}\n"

    city = doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label12").inner_html.strip
    province = doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_Label4").inner_html.strip

    mp_info = {
      'riding' => doc.search("#ctl00_cphContent_repMP_ctl00_lblYellowBar").inner_html.strip,
      'name' => name,
      'city' => city,
      'province' => province,
      'email' => doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_HyperLink1").inner_html.strip,
      'party' => doc.search("#ctl00_cphContent_repMP_ctl00_lnkParty").inner_html.strip,
      'parliamentary_address' => {
        'address' => paddress.strip,
        'telephone' => doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_repParliamentaryTelephones_ctl00_lblTelephonenumber").inner_html.strip,
        'fax' => doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_repParliamentaryTelephones_ctl01_lblTelephonenumber").inner_html.strip,
        'email' => doc.search("#ctl00_cphContent_repMP_ctl00_grdParliamentaryAddress_ctl02_HyperLink1").inner_html.strip,
      },
      'local_address' => {
        'address' => laddress.strip,
        'telephone' => doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_repConstituencyTelephones_ctl00_lblTelephonenumber").inner_html.strip,
        'fax' => doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_repConstituencyTelephones_ctl01_lblTelephonenumber").inner_html.strip,
        'email' => doc.search("#ctl00_cphContent_repMP_ctl00_grdConstituencyAddress_ctl02_HyperLink1").inner_html.strip,
      }
    }

    mp_info
  end
end
