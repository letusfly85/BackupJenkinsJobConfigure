import System.Environment
import System.Directory
import System.FilePath

main = do jenkinsHome <- getEnv "JENKINS_HOME"

          curDir <- getCurrentDirectory
          let arcDir = curDir </> "archives"
          arcExist <- doesDirectoryExist arcDir
          if arcExist then
              do
                return ()
          else
              do
                createDirectory arcDir

          dirExist <- doesDirectoryExist jenkinsHome
          if dirExist then
              do 
                -- start backup
                putStrLn "start jenkins cofigures backup."
             
                putStrLn $ "jenkins home is " ++ jenkinsHome
                list <- getJobList jenkinsHome
                copyJobConfigures jenkinsHome list

          else
              do
                putStrLn "no jenkins home in your machine.."


getJobList :: FilePath -> IO [FilePath]
getJobList jenkinsHome = do
    list <- getDirectoryContents $ jenkinsHome </> "jobs"
    return $ filter (\f -> not $ elem f [".", ".."]) list

copyJobConfigures :: FilePath -> [FilePath] -> IO ()
copyJobConfigures jenkinsHome []     = do return ()
copyJobConfigures jenkinsHome (f:fs) = do
    curDir <- getCurrentDirectory
    let backupDir = curDir </> "archives" </> f
    
    backupDirExist <- doesDirectoryExist backupDir
    if backupDirExist then
        do 
            return ()
    else
        do
            createDirectory backupDir


    let configFile = jenkinsHome </> "jobs" </> f </> "config.xml"
    putStrLn $ " ++++ copy configure file " ++ configFile
    configureExist <- doesFileExist configFile
    if configureExist then
        do
            copyFile configFile $ backupDir </> "config.xml"
    else
        do
            return ()
    copyJobConfigures jenkinsHome fs
