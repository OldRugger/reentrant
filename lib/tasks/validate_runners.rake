
# require "#{Rails.root}/app/helpers/application_helper"
# include ApplicationHelper

namespace :runners do
  desc "set display values for split times"
  task validate: :environment do
    count = Runner.all.count
    evaluated = 0
    errors    = 0
    fix_know_issues
    Runner.all.each do |r|
      evaluated += 1
      next if ( HIGH_SCHOOL_LIST.include?(r.club_description) and ['M', 'F'].include?(r.sex) )
      try_to_fix_club_name(r)
      next if ( HIGH_SCHOOL_LIST.include?(r.club_description) and ['M', 'F'].include?(r.sex) )
      next if r.surname == "Admin"
      errors += 1
      puts "#{r.id}: #{r.firstname} #{r.surname}, #{r.sex}, '#{r.club_description}'"
    end
   puts "begenning record count:  #{count}. evaluated: #{evaluated}, errors: #{errors}"
  end
  
  def try_to_fix_club_name(r)
    r.club_description.strip! if r.club_description
  end
  
  def fix_know_issues
    # remomve non-HS runners
    Runner.where(club_description: ["GAOC", "A/L", "OAL", "At Large / No Club / Not Listed",
                                    "BSA", "Georgia Orienteering Club", "Boy Scouts", "Carolina Orienteering Klubb",
                                    "At Large", "Vulcan Orienteering Club", "UWG", "Hillgrove Instructor",
                                    "US Army", "Kennesaw Mountain Parent", "Lassiter HS (NC)",
                                    "Kennesaw Mountain (NC)", "Lassiter (NC)", "North Cobb HS (NC)",
                                    "North Cobb HS (NC)", "North Cobb(NC)", "North Cobb (NC)", "VOC",
                                    "Union Grove  (NC)", "North Cobb  (NC)", "Chapel Hill   (NC)",
                                    "Georgia Orienteering Club ", "Kennesaw Mountain(NC)", "MLK HS (NC)",
                                    "Luella HS (NC)", "Hillgrove (NC)"]).delete_all
    Runner.where("length(club_description) < 2").delete_all
    
    # correct school descriptions
    Runner.where(club_description: "HillgroveHS").update_all(club_description: "Hillgrove HS")
    Runner.where(club_description: "MLK HS").update_all(club_description: "Martin Luther King HS")
    Runner.where(club_description: "Kennesaw Mtn HS").update_all(club_description: "Kennesaw Mountain HS")
    Runner.where(club_description: "UnionGrove HS").update_all(club_description: "Union Grove HS")
    Runner.where(club_description: "Henry Co HS").update_all(club_description: "Henry County HS")
    Runner.where(club_description: "SW DeKalb HS").update_all(club_description: "Southwest DeKalb HS")
    Runner.where(club_description: "Woodstock").update_all(club_description: "Woodstock HS")
    Runner.where(club_description: "Stephenson").update_all(club_description: "Stephenson HS")
    Runner.where(club_description: "Cedar Grove").update_all(club_description: "Cedar Grove HS")
    Runner.where(club_description: "NCHS").update_all(club_description: "North Cobb HS")
    Runner.where(club_description: "Henry County HS-GA").update_all(club_description: "Henry County HS")
    Runner.where(club_description: "Coffee County HS").update_all(club_description: "Coffee HS")
    Runner.where(club_description: "LueHS").update_all(club_description: "Luella HS")
    Runner.where(club_description: "Vetrans HS").update_all(club_description: "Veterans HS")
    Runner.where(club_description: "Northside HS").update_all(club_description: "Northside HS (WR)")
    Runner.where(club_description: "JacHS").update_all(club_description: "Jackson HS")
    # correct gender settings
    Runner.find(283).update(sex: "M")
    Runner.find(316).update(sex: "M")
    Runner.find(905).update(sex: "M")
    Runner.find(906).update(sex: "M")
    Runner.find(907).update(sex: "M")
    Runner.find(908).update(sex: "M")
    Runner.find(909).update(sex: "M")
    Runner.find(910).update(sex: "M")
    Runner.find(911).update(sex: "M")
    Runner.find(912).update(sex: "M")
    Runner.find(913).update(sex: "M")
    Runner.find(914).update(sex: "M")
    Runner.find(915).update(sex: "M")
    Runner.find(916).update(sex: "M")
    Runner.find(917).update(sex: "F")
    Runner.find(918).update(sex: "F")
    Runner.find(919).update(sex: "M")
    Runner.find(920).update(sex: "M")
    Runner.find(921).update(sex: "F")
    Runner.find(922).update(sex: "M")
    Runner.find(923).update(sex: "M")
    Runner.find(924).update(sex: "M")
    Runner.find(925).update(sex: "M")
    Runner.find(926).update(sex: "M")
    Runner.find(927).update(sex: "M")
    Runner.find(928).update(sex: "M")
    Runner.find(929).update(sex: "M")
    Runner.find(930).update(sex: "M")
    Runner.find(931).update(sex: "M")
    Runner.find(932).update(sex: "M")
    Runner.find(933).update(sex: "M")
    Runner.find(934).update(sex: "M")
    Runner.find(935).update(sex: "M")
    Runner.find(936).update(sex: "M")
    Runner.find(937).update(sex: "M")
    Runner.find(938).update(sex: "F")
    Runner.find(939).update(sex: "F")
    Runner.find(940).update(sex: "F")
    Runner.find(941).update(sex: "F")
    Runner.find(942).update(sex: "F")
    Runner.find(943).update(sex: "M")
    Runner.find(944).update(sex: "M")
    Runner.find(945).update(sex: "M")
    Runner.find(946).update(sex: "M")
    Runner.find(947).update(sex: "M")
    Runner.find(948).update(sex: "M")
    Runner.find(949).update(sex: "M")
    Runner.find(950).update(sex: "M")
    Runner.find(951).update(sex: "M")
    Runner.find(953).update(sex: "M")
    Runner.find(954).update(sex: "M")
    Runner.find(955).update(sex: "M")
    Runner.find(956).update(sex: "M")
    Runner.find(958).update(sex: "F")
    Runner.find(959).update(sex: "F")
    Runner.find(960).update(sex: "F")
    Runner.find(961).update(sex: "F")
    Runner.find(962).update(sex: "F")
    Runner.find(963).update(sex: "F")
    Runner.find(964).update(sex: "F")
    Runner.find(965).update(sex: "F")
    Runner.find(1058).update(sex: "M")
    Runner.find(1059).update(sex: "M")
    Runner.find(1060).update(sex: "F")
    Runner.find(1062).update(sex: "F")
    Runner.find(1063).update(sex: "M")
    Runner.find(1064).update(sex: "M")
    Runner.find(1064).update(sex: "M")
    Runner.find(1065).update(sex: "M")
    Runner.find(1066).update(sex: "M")
    Runner.find(1067).update(sex: "M")
    Runner.find(1068).update(sex: "M")
    Runner.find(1069).update(sex: "F")
    Runner.find(1070).update(sex: "F")
    Runner.find(1071).update(sex: "F")
    Runner.find(1072).update(sex: "M")
    Runner.find(1073).update(sex: "M")
    Runner.find(1074).update(sex: "M")
    Runner.find(1075).update(sex: "M")
    Runner.find(1076).update(sex: "M")
    Runner.find(1077).update(sex: "M")
    Runner.find(1078).update(sex: "M")
    Runner.find(1079).update(sex: "M")
    Runner.find(1080).update(sex: "M")
    Runner.find(1081).update(sex: "M")
    Runner.find(1082).update(sex: "F")
    Runner.find(1083).update(sex: "F")
    Runner.find(1084).update(sex: "F")
    Runner.find(1085).update(sex: "M")
    Runner.find(1086).update(sex: "M")
    Runner.find(1087).update(sex: "M")
    Runner.find(1088).update(sex: "M")
    Runner.find(1089).update(sex: "M")
    Runner.find(1090).update(sex: "M")
    Runner.find(1091).update(sex: "M")
    Runner.find(1092).update(sex: "M")
    Runner.find(1093).update(sex: "F")
    Runner.find(1131).update(sex: "F")


    # clean up duplicates:
    begin
      Runner.find(904).delete
    rescue ActiveRecord::RecordNotFound
    end
    begin
      Runner.find(981).delete
    rescue ActiveRecord::RecordNotFound
    end
      
  end

end
