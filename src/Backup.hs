import System.Environment
import System.Directory

main = do jenkinsHome <- getEnv "JENKINS_HOME"
          dirExist <- doesDirectoryExist jenkinsHome

          if dirExist then
             -- start backup
             putStrLn "start jenkins cofigures backup."

             -- TODO
             putStrLn jenkinsHome

          else
             putStrLn "no jenkins home in your machine.."
