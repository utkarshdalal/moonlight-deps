@echo on  # This will show each command being executed.
echo "Starting build process..."

set REPO_PATH=..\..\..\SDL
echo "Repository path set to: %REPO_PATH%"

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF
echo "Compiler flags set."

echo "Creating build directory for %1..."
mkdir build_%1
cd build_%1
echo "Running CMake..."
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL_LIBC=ON -A %2 %REPO_PATH%
echo "Building with CMake..."
cmake --build . --config Release -v
echo "Installing build..."
cmake --install . --prefix ..\install_%1 --config Release -v
cd ..
echo "Build and installation completed successfully."
echo "Listing contents of the build directory..."
dir build_%1 /S

echo "Listing contents of the installation directory..."
dir ..\install_%1 /S

cd ..