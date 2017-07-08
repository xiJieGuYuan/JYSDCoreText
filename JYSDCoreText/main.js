
require("UIColor, NSArray, UILabel, UIColor, UIColor");

defineClass("JSPathViewController", {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.setNav();
            self.logErrorArray();
            self.createTextLabel();
            },
            setNav: function() {
            self.setTitle("JSPathSucess");
            self.view().setBackgroundColor(UIColor.yellowColor());
            },
            logErrorArray: function() {
            var array = NSArray.arrayWithObjects("1", "1", "1", "1", null);
            for (var i = 0; i < array.count(); i++) {
            
            }
            },
            
            createTextLabel: function() {
            
            var label = UILabel.alloc().initWithFrame({x:20, y:20, width:350, height:100});
            label.setText("JSPathSucess 此次更新的内容: 显示当前语句!");
            label.setTextColor(UIColor.orangeColor());
            label.setBackgroundColor(UIColor.cyanColor());
            label.setCenter(self.view().center());
            self.view().addSubview(label);
            }
            }, {});

