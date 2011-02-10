module StringExtension
  def to_js
    '<script type="text/javascript">'+self+'</script>'
  end
  
  def clear_js
    self.
      gsub('<script type="text/javascript">', "").
      gsub('</script>', "")
  end
  
end

String.send :include, StringExtension


