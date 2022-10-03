using Pkg
Pkg.add("PkgTemplates")

using PkgTemplates
tpl = Template()

#`user="<laral>"`
#(user.name="<laral>",user.email="<laralaban@outlook.com>",github.user="<larasupernovae>")
#git config --global

# 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