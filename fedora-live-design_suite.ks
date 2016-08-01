# fedora-design-suite.ks
# Based on Live Workstation
# Description:
# - A Spin targeted towards professional designers
# Website: http://fedoraproject.org/wiki/Design_Suite
# Maintainers:
# - Luya Tshimbalanga <luya AT fedoraproject DOT org>
# - Previous maintainer Sebastian Dziallas

%include fedora-live-workstation.ks

# Size partition
part / --size 14336

%packages
# Switch to groups for design suite
@design-suite

# Added addons to address rhbz#1336879 from dnf
gimp-data-extras
gimp-dbp
gimp-dds-plugin
gimp-elsamuko
gimp-fourier-plugin
gimp-gap
gimp-help
gimp-help-browser
gimp-high-pass-filter
gimp-layer-via-copy-cut
gimp-lensfun
gimp-lqr-plugin
gimp-normalmap
gimp-paint-studio
gimp-resynthesizer
gimp-save-for-web
gimp-separate+
gimp-wavelet-denoise-plugin
gimpfx-foundry
gmic-gimp
inkscape-psd
inkscape-sozi
LuxRender-blender
sane-backends-drivers-scanners
xsane-gimp
#YafaRay-blender

# Preview Gnome Photos
gnome-photos

# Add gthumb for renaming group files
gthumb

# Extra wallpapers
f23-backgrounds-extras-base
f23-backgrounds-extras-gnome
f24-backgrounds-extras-base
f24-backgrounds-extras-gnome

# temporary removal of package for testing purpose
-LuxRender-blender
-libreoffice-pdfimporter
-unoconv

# removal of unneeded applications
-gnome-boxes
-eog
-rdesktop

%end

%post
#Override the favorite desktop application in Dash
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'shotwell.desktop', 'darktable.desktop', 'gimp.desktop', 'inkscape.desktop', 'blender.desktop', 'libreoffice-writer.desktop', 'scribus.desktop', 'nautilus.desktop', 'bijiben.desktop', 'anaconda.desktop', 'list-design-tutorials.desktop']
FOE

# Add link to lists of tutorials
cat >> /usr/share/applications/list-design-tutorials.desktop << FOE
[Desktop Entry]
Name=List of design tutorials
GenericName=List of Tutorials for Designers
Comment=Reference of Design Related Tutorials
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite/Tutorials
Type=Application
Icon=applications-graphics
Categories=Graphics;Documentation;
FOE
chmod a+x /usr/share/applications/list-design-tutorials.desktop

# Add information about Fedora Design Suite
cat >> /usr/share/applications/fedora-design-suite.desktop << FOE
[Desktop Entry]
Name=Design Suite Info
GenericName=About Design Suite
Comment=Wiki page of Design Suite
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-suite.desktop

# Add information about Fedora Design Team
cat >> /usr/share/applications/fedora-design-team.desktop << FOE
[Desktop Entry]
Name=Design Team Info
GenericName=About Design Team 
Comment=Wiki page of Design Team
Exec=xdg-open https://fedoraproject.org/wiki/Design
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-team.desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
