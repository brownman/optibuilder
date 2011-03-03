class TestPmd < ActiveRecord::Base
  belongs_to :fiber

    #media
     def mean
        (self.pmd_set1_a + self.pmd_set1_b + self.pmd_set1_c + self.pmd_set2_a + self.pmd_set2_b + self.pmd_set2_c + self.pmd_set3_a + self.pmd_set3_b + self.pmd_set3_c) / 9
     end

    #valor máximo
    def max
      [self.pmd_set1_a , self.pmd_set1_b , self.pmd_set1_c , self.pmd_set2_a , self.pmd_set2_b , self.pmd_set2_c , self.pmd_set3_a , self.pmd_set3_b , self.pmd_set3_c].max ;
    end

    # valor máximo
    def span
       self.max
    end

    #coef = span/raiz quadrada do OPTICAL SPAN LENGTH [km]
    def coef
           self.max/Math.sqrt(self.optical_length)
    end

    def std
      Math.sqrt((((self.pmd_set1_a - self.mean )**2)+((self.pmd_set1_b - self.mean )**2)+((self.pmd_set1_c - self.mean )**2)+((self.pmd_set2_a - self.mean )**2)+((self.pmd_set2_b - self.mean )**2)+((self.pmd_set2_c - self.mean )**2)+((self.pmd_set3_a - self.mean )**2)+((self.pmd_set3_b - self.mean )**2)+((self.pmd_set3_c - self.mean )**2))/8)
    end


end
