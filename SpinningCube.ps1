# Joel Roth 2016

# Ported from OpenTK sample "ImmediateMode"
# https://github.com/opentk/opentk/blob/master/Source/Examples/OpenGL/1.x/ImmediateMode.cs

Remove-Variable * -ErrorAction SilentlyContinue

[Reflection.Assembly]::LoadFile("\\path\to\OpenTK.dll")
[Reflection.Assembly]::LoadFile("\\path\to\OpenTK.GLControl.dll")

$DebugPreference = "Continue"

$window = [OpenTK.GameWindow]::New()
$window = New-Object OpenTK.GameWindow
$window.Title = "omg why did I do this"
$gl = [OpenTK.Graphics.OpenGL.GL]
$global:rotationspeed = 180.0
$global:angle = 0

$window.add_Load({ 
    $window.VSync = [OpenTK.VSyncMode]::On 
    $gl::Enable([OpenTK.Graphics.OpenGL.EnableCap]::DepthTest)
    $gl::ClearColor([System.Drawing.Color]::FromArgb(255,1,36,86))
})
$window.add_Resize({ 
    $gl::Viewport(0, 0, $window.Width, $window.Height); 
    $aspectratio = [double]$window.Width / [double]$window.Height
    $perspective = [OpenTK.Matrix4]::CreatePerspectiveFieldOfView([OpenTK.MathHelper]::PiOver4,$aspectratio,1,64)
    $gl::MatrixMode([OpenTK.Graphics.OpenGL.MatrixMode]::Projection)
    $gl::LoadMatrix([ref]$perspective)
})
$window.add_KeyDown({
    if ($_.Key -eq [OpenTK.Input.Key]::Escape) {
        $window.Close() 
    }
    elseif ($_.Key -eq [OpenTK.Input.Key]::Space) {
        Write-Debug "Space pressed"
    }
})
function DrawCube()
{
    $GL::Begin([OpenTK.Graphics.OpenGL.PrimitiveType]::Quads)

    $GL::Color3([System.Drawing.Color]::Silver)
    $GL::Vertex3(-1.0, -1.0, -1.0)
    $GL::Vertex3(-1.0, 1.0, -1.0)
    $GL::Vertex3(1.0, 1.0, -1.0)
    $GL::Vertex3(1.0, -1.0, -1.0)

    $GL::Color3([System.Drawing.Color]::Honeydew)
    $GL::Vertex3(-1.0, -1.0, -1.0)
    $GL::Vertex3(1.0, -1.0, -1.0)
    $GL::Vertex3(1.0, -1.0, 1.0)
    $GL::Vertex3(-1.0, -1.0, 1.0)

    $GL::Color3([System.Drawing.Color]::Moccasin)

    $GL::Vertex3(-1.0, -1.0, -1.0)
    $GL::Vertex3(-1.0, -1.0, 1.0)
    $GL::Vertex3(-1.0, 1.0, 1.0)
    $GL::Vertex3(-1.0, 1.0, -1.0)
    
    $GL::Color3([System.Drawing.Color]::IndianRed)
    $GL::Vertex3(-1.0, -1.0, 1.0)
    $GL::Vertex3(1.0, -1.0, 1.0)
    $GL::Vertex3(1.0, 1.0, 1.0)
    $GL::Vertex3(-1.0, 1.0, 1.0)
    
    $GL::Color3([System.Drawing.Color]::PaleVioletRed)
    $GL::Vertex3(-1.0, 1.0, -1.0)
    $GL::Vertex3(-1.0, 1.0, 1.0)
    $GL::Vertex3(1.0, 1.0, 1.0)
    $GL::Vertex3(1.0, 1.0, -1.0)
    
    $GL::Color3([System.Drawing.Color]::ForestGreen)
    $GL::Vertex3(1.0, -1.0, -1.0)
    $GL::Vertex3(1.0, 1.0, -1.0)
    $GL::Vertex3(1.0, 1.0, 1.0)
    $GL::Vertex3(1.0, -1.0, 1.0)
    
    $GL::End()
}

$window.add_RenderFrame({
    $gl::Clear([OpenTK.Graphics.OpenGL.ClearBufferMask]::ColorBufferBit)
    $gl::Clear([OpenTK.Graphics.OpenGL.ClearBufferMask]::DepthBufferBit)
    
    $lookat = [OpenTK.Matrix4]::LookAt(0, 5, 5, 0, 0, 0, 0, 1, 0)
    $gl::MatrixMode([OpenTK.Graphics.OpenGL.MatrixMode]::Modelview)
    $gl::LoadMatrix([ref]$lookat)

    $global:angle += $global:rotationspeed * $_.time
    $gl::Rotate($global:angle,0.0,1.0,0.0)

    DrawCube
    $window.SwapBuffers()
})

$window.Run(60)
