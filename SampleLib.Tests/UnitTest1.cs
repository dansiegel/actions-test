namespace SampleLib.Tests;

public class UnitTest1
{
    [Fact]
    public void Test1()
    {
        Assert.True(true);
    }

    // [Fact]
    // public void FailingTest()
    // {
    //     Assert.True(false);
    // }

    [Fact(Skip = "CI Test")]
    public void TestToSkip()
    {
        // Some Random Change
    }
}